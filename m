Return-Path: <linux-kernel-owner+w=401wt.eu-S932283AbWLRXst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbWLRXst (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 18:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbWLRXst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 18:48:49 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:53923 "EHLO
	tirith.ics.muni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932281AbWLRXss (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 18:48:48 -0500
Message-ID: <458728D1.9090209@gmail.com>
Date: Tue, 19 Dec 2006 00:48:33 +0100
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] Char: isicom, fix probe race
References: <2880031291415520798@wsc.cz>	<29302220751300732488@wsc.cz> <20061218152730.0d86c4c7.akpm@osdl.org>
In-Reply-To: <20061218152730.0d86c4c7.akpm@osdl.org>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Muni-Spam-TestIP: 147.251.48.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Sat, 16 Dec 2006 02:09:48 +0100 (CET)
> Jiri Slaby <jirislaby@gmail.com> wrote:
> 
>> isicom, fix probe race
>>
>> Fix two race conditions in the probe function with mutex.
>>
>> ...
>>
>>  static int __devinit isicom_probe(struct pci_dev *pdev,
>>  	const struct pci_device_id *ent)
>>  {
>> +	static DEFINE_MUTEX(probe_lock);
> 
> hm.  How can isicom_probe() race with itself?  Even with the dreaded
> multithreaded-pci-probing?  It's only called once, by a single thread.
> 
> Confused.

Yeah, I'm a little bit too now. One of developers want me to do this some time
ago and I did it without deep thinking about that. Now, I did it again and as
you wrote, it's completely unreasonable. Please, throw it
(char-isicom-fix-probe-race.patch) away.

thanks,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
