Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbVKZUCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbVKZUCF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 15:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbVKZUCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 15:02:05 -0500
Received: from main.gmane.org ([80.91.229.2]:10478 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750726AbVKZUCE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 15:02:04 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Matthijs Melchior <mmelchior@xs4all.nl>
Subject: Re: Ordered Sorted List
Date: Sat, 26 Nov 2005 12:03:14 +0100
Message-ID: <dm9fdj$esk$1@sea.gmane.org>
References: <1131.62.1.12.53.1133000719.squirrel@webmail.wired-net.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: zwaan.xs4all.nl
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
In-Reply-To: <1131.62.1.12.53.1133000719.squirrel@webmail.wired-net.gr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nanakos Chrysostomos wrote:
> Hi ,all.Can someone please explain this source code with an example???
.....
> void slistInsert(slist *sp,int t)
> {
>         ListNode *n=(ListNode *)malloc(sizeof(ListNode));
>         if(n == NULL)
>         {
>                 printf("Out of memory\n");
>                 exit(1);
>         }
>         n->data = t;
>         while(*sp!=NULL && (*sp)->data < t)
>         {
>         	sp = &((*sp)->next);   // Why we do this here,i miss this point

This is done to move to the next item in the list.
The expression is complicated because 'sp' is a pointer to a pointer to
a structure.

>         }
>         n->next = *sp;
>         *sp = n;
> 
> }
> 
.....

-- 
Matthijs Melchior.

