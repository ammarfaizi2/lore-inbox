Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262177AbVDFMON@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262177AbVDFMON (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 08:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262188AbVDFMLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 08:11:10 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:56999 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262180AbVDFMJh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 08:09:37 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: =?iso-8859-1?q?J=F6rn=20Engel?= <joern@wohnheim.fh-wedel.de>,
       Paulo Marques <pmarques@grupopie.com>
Subject: Re: RFC: turn kmalloc+memset(,0,) into kcalloc
Date: Wed, 6 Apr 2005 15:09:24 +0300
User-Agent: KMail/1.5.4
Cc: LKML <linux-kernel@vger.kernel.org>
References: <4252BC37.8030306@grupopie.com> <20050405180007.GD12536@wohnheim.fh-wedel.de>
In-Reply-To: <20050405180007.GD12536@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200504061509.24075.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 April 2005 21:00, Jörn Engel wrote:
> On Tue, 5 April 2005 17:26:31 +0100, Paulo Marques wrote:
> > 
> > Would this be a good thing to clean up, or isn't it worth the effort at all?
> 
> I would welcome such a stream of patches.  But in spite of the calloc
> interface being rather stupid, I'd prefer to see patches with kcalloc
> instead of kmalloc_zero.

kcalloc call will have three params pushed on stack. in 99% of cases
it could be done with two. If anyone's going to do it, please create
and use

void *kzalloc(size, gfp_mask)

or zalloc, kmalloc_zero... whatever.
--
vda

