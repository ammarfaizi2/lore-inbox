Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964859AbWIZVul@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964859AbWIZVul (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 17:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964860AbWIZVul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 17:50:41 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:40793 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964859AbWIZVuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 17:50:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=QkVow+qOC2KmJChVrs+b8XqGQ5Rnkb4qvUTxjZxgylokzsVbWPGjHrjTmJH2wN/4Nx/RHdSe+QYAt7GqbSRPeUspFyse632C39lmpIWx9RIrtJSM3QYkcI0wiosiyiy+z+2n9qRo7VBDYkZHD3uhwizBVJNsxpuxWlur8WoRTlI=
Message-ID: <4519A0B0.3030207@gmail.com>
Date: Tue, 26 Sep 2006 23:50:40 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Janne Karhunen <janne.karhunen@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel threads and signals
References: <24c1515f0609260152j256e8473yf2e4d14e65222c67@mail.gmail.com>
In-Reply-To: <24c1515f0609260152j256e8473yf2e4d14e65222c67@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Janne Karhunen wrote:
> Hi,
> 
> I have a kernel module foo that uses kernel thread bar. With
> signal_pending() I can easily check whether or not thread has
> pending signals, but what's the correct way to check for the
> specific signal number(s)?

I am not pretty sure, but spinlock;dequeue_signal;spinunlock; should work.

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
