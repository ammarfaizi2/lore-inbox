Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965053AbVKGTWv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965053AbVKGTWv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 14:22:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965124AbVKGTWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 14:22:51 -0500
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:47778 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S965053AbVKGTWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 14:22:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=poaYUEz0HZyLcWscTUqF2eVpYcV+wndT9jdkWTwxiWbAI+x3PGtWxZDpYZtf+5JWxe6AQkG3vSD7dtzvJt9OKudWFuywJbB2FbfXZGbG8N1aiVuQ4CC94ppURbQGsfUHBdFMWd3Lwwwbp53b6kuB67BYDvwuNOgs9mifnZJWVWA=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Subject: Re: [uml-devel] [PATCH 8/10] UML - Maintain own LDT entries
Date: Mon, 7 Nov 2005 20:28:22 +0100
User-Agent: KMail/1.8.3
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>,
       linux-kernel@vger.kernel.org, Allan Graves <allan.graves@oracle.com>
References: <200510310439.j9V4dfbw000872@ccure.user-mode-linux.org> <200511022051.24335.blaisorblade@yahoo.it> <436F469B.3080607@fujitsu-siemens.com>
In-Reply-To: <436F469B.3080607@fujitsu-siemens.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511072028.23111.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 November 2005 13:20, Bodo Stroesser wrote:
> Blaisorblade wrote:
> > On Monday 31 October 2005 05:39, Jeff Dike wrote:
> >>From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

> > Or at least so I think (I must still give a proper look afterwards, and
> > I'll post patches). Actually it seems that this is done on purpose, but I
> > don't agree too much on this. I will see.

>  From the beginning my new code for SKAS included the checks/buffering you
> later inserted for TT and SKAS. So this patch is a second version adapted
> to your changes. It shifts your improvements into TT path only (where I
> didn't do any changes in my old patch), while it uses my own stuff for
> SKAS. Thus the patch doesn't really revert your improvements, but restricts
> it to TT. As in SKAS0 UML now holds its own LDT data, there is no need for
> buffering in this case. So I think it makes sense to have separate code for
> SKAS.
Yep, ok - I'm undecided about the new code for SKAS3, but it may make sense 
(i.e. no opinion).

Instead, I have another question: is there a proper reason for using the 
processor format for storing the info and translating it back to (struct 
user_desc)? I am planning to avoid this double translation because I don't 
like it. Any opinion?
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
