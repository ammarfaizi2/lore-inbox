Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161189AbWG1R02@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161189AbWG1R02 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 13:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161191AbWG1R02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 13:26:28 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:63449 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1161189AbWG1R02 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 13:26:28 -0400
Subject: Re: [patch 2/5] Add the Kconfig option for the stackprotector
	feature
From: Arjan van de Ven <arjan@linux.intel.com>
To: =?iso-8859-2?Q?Pawe=B3?= Sikora <pluto@agmk.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200607281913.37889.pluto@agmk.net>
References: <1154102546.6416.9.camel@laptopd505.fenrus.org>
	 <1154102627.6416.13.camel@laptopd505.fenrus.org>
	 <1154103895.18669.5.camel@c-67-188-28-158.hsd1.ca.comcast.net>
	 <200607281913.37889.pluto@agmk.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Date: Fri, 28 Jul 2006 19:26:22 +0200
Message-Id: <1154107582.6416.34.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-28 at 19:13 +0200, Paweł Sikora wrote:
> 
> yes, it could.
> 
> gcc supports stack protection at so called tree-level (it means
> it's architecture-independent). i've just tested a simple
> userland-code:

in userland it works, no question about that.
The problem comes when you want to use this userland abi in kernel
space; for x86-64 it could be done by a 20 line gcc patch, on some other
architectures... it's going to be really incredibly hard.

I'd have loved to make this more generic... but the mechanism behind
this technology on the gcc side is very architecture specific.

