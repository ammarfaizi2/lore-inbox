Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267860AbUJGTZq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267860AbUJGTZq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 15:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267921AbUJGTX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 15:23:29 -0400
Received: from h66-38-154-67.gtcust.grouptelecom.net ([66.38.154.67]:13529
	"EHLO pbl.ca") by vger.kernel.org with ESMTP id S267595AbUJGTVP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 15:21:15 -0400
Message-ID: <4165983E.5060605@pbl.ca>
Date: Thu, 07 Oct 2004 14:25:50 -0500
From: Aleksandar Milivojevic <amilivojevic@pbl.ca>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [2.4] 0-order allocation failed
References: <200410071318.21091.mbuesch@freenet.de> <20041007151518.GA14614@logos.cnet> <200410071917.40896.mbuesch@freenet.de> <20041007153929.GB14614@logos.cnet> <x67jq2bcy3@gzp> <20041007164221.GD14614@logos.cnet>
In-Reply-To: <20041007164221.GD14614@logos.cnet>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> On Thu, Oct 07, 2004 at 08:28:04PM +0200, Gabor Z. Papp wrote:
>>
>>There is really no way to run 2.4 without swap?
> 
> Nope. Any kernel can't. The thing is the system overcommits 
> memory (it allows applications to allocate more memory than the system 
> is able to handle).
> 
> If there is no place to "save" that memory once you run out of it,
> you're dead. Its a physical problem. :)

Hm, shouldn't there be command line option to instruct kernel not to 
overcommit memory?  For servers that don't really need disk, and 
wouldn't have much use for swap anyhow (like firewalls for example).  I 
do vaugly remember of such option in OSF/1 (Compaq Unix or whatever it 
is called nowdays) or Solaris.  Not sure which one.  Or maybe both.  If 
I remember correctly, there the default was not to overcommit, and (not 
recommended) option would allow kernel to overcommit.  Or I might be 
wrong about the default setting, but the option was there.  I don't 
remember if application that tried to allocate more memory that there 
was free on the system would be killed or if system call would simply fail.

-- 
Aleksandar Milivojevic <amilivojevic@pbl.ca>    Pollard Banknote Limited
Systems Administrator                           1499 Buffalo Place
Tel: (204) 474-2323 ext 276                     Winnipeg, MB  R3T 1L7
