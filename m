Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932282AbWFRSrg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbWFRSrg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 14:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbWFRSrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 14:47:36 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:39629 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932279AbWFRSrf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 14:47:35 -0400
Date: Sun, 18 Jun 2006 19:47:34 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: dlezcano@fr.ibm.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, serue@us.ibm.com,
       haveblue@us.ibm.com, clg@fr.ibm.com
Subject: Re: [RFC] [patch 0/6] [Network namespace] introduction
Message-ID: <20060618184734.GB27946@ftp.linux.org.uk>
References: <20060609210202.215291000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060609210202.215291000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2006 at 11:02:02PM +0200, dlezcano@fr.ibm.com wrote:
> What is missing ?
> -----------------
> The routes are not yet isolated, that implies:
> 
>    - binding to another container's address is allowed
> 
>    - an outgoing packet which has an unset source address can
>      potentially get another container's address
> 
>    - an incoming packet can be routed to the wrong container if there
>      are several containers listening to the same addr:port

- renaming an interface in one "namespace" affects everyone.
