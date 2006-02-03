Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751258AbWBCGVs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbWBCGVs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 01:21:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbWBCGVs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 01:21:48 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:21131 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1751258AbWBCGVr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 01:21:47 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: Bernd Eckenfels <be-news06@lina.inka.de>
Subject: Re: Recursive chmod/chown OOM kills box with 32MB RAM
Date: Fri, 3 Feb 2006 08:21:10 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <E1F4JnT-0004pE-00@calista.inka.de>
In-Reply-To: <E1F4JnT-0004pE-00@calista.inka.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602030821.10575.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 February 2006 17:21, Bernd Eckenfels wrote:
> Denis Vlasenko <vda@ilport.com.ua> wrote:
> > # umount /.3
> > umount: /.3: device is busy
> > # lsof -nP | grep -F '/.3'
> > # lsof -nP | grep -F 'sdc'
> 
> You can try "lsof +f -- /.3" also

Didn't help, but later I found it.
Kernel nfsd daemon was keeping it busy.
It's not visible in lsof.
--
vda
