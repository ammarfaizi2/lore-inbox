Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265328AbUBPCS2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 21:18:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265327AbUBPCS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 21:18:27 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56468 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265329AbUBPCSJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 21:18:09 -0500
Message-ID: <40302845.5010503@pobox.com>
Date: Sun, 15 Feb 2004 21:17:41 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Christophe Saout <christophe@saout.de>, hch@infradead.org,
       thornber@redhat.com, mikenc@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: dm-crypt using kthread
References: <402A4B52.1080800@centrum.cz>	<1076866470.20140.13.camel@leto.cs.pocnet.net>	<20040215180226.A8426@infradead.org>	<1076870572.20140.16.camel@leto.cs.pocnet.net>	<20040215185331.A8719@infradead.org>	<1076873760.21477.8.camel@leto.cs.pocnet.net>	<20040215194633.A8948@infradead.org>	<20040216014433.GA5430@leto.cs.pocnet.net> <20040215180736.4743f4ee.akpm@osdl.org>
In-Reply-To: <20040215180736.4743f4ee.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
>>+static void crypt_encode_key(char *hex, u8 *key, int size)
>>+{
>>+	static char hex_digits[] = "0123456789abcdef";
>>+	int i;
>>+
>>+	for(i = 0; i < size; i++) {
>>+		*hex++ = hex_digits[*key >> 4];
>>+		*hex++ = hex_digits[*key & 0x0f];
>>+		key++;
>>+	}
>>+
>>+	*hex++ = '\0';
>>+}
> 
> 
> sprintf("%02x")?


I was thinking that too.  How often do we encode the key?  If not often 
(and I would guess not), sprintf would be more than sufficient.

	Jeff



