Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964793AbWIPM6e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964793AbWIPM6e (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 08:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964799AbWIPM6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 08:58:34 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:59656 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S964793AbWIPM6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 08:58:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Xes8MobtaG5YAdbuHyYwN5z5I0p6wQ3eeIS07XwAxf1hBL7ssf3L/myYJPF51sz1Dw+LFMxhA+12zoReoToCSn2njsofhR7U5xjPU2F6IXRf7YVNQhHcihLylM/IP0R684UdEMQeJVhhYPlZ/RTRUQj3+c7301F+coF6icmnHSQ=
Message-ID: <450BF4E9.2040407@gmail.com>
Date: Sat, 16 Sep 2006 14:57:54 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mxser: PCI refcounts
References: <1158329578.29932.38.camel@localhost.localdomain> <450BF0A1.4040807@gmail.com>
In-Reply-To: <450BF0A1.4040807@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby wrote:
> Alan Cox wrote:
>> Switch to pci ref counts for mxser when handling PCI devices. Use
>> pci_get_device and drop the reference when we finish and unload.
> 
> Please, don't do that. These all drivers need to be rewritten to pci 
> probing (for this one I have a patch, but I waited for confirmation of 
> previous patchset, but nothing has come, so perhaps I will clone it as 
> NEW/EXPERIMENTAL 1.9.1-with-pci-probing-driver) and when pci_find_device 
> is there, we can `grep -r` it to know, which drivers need that. The same 

Just a note. I tried to do all this work, but it was nacked:
http://www.fi.muni.cz/~xslaby/unpr/linux_patches/pci_find/

You can pick up from there some patches for non-device drivers (such as buses or 
so), if you want to not do the work yourself again...

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
