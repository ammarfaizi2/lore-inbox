Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265414AbTB0QVd>; Thu, 27 Feb 2003 11:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265446AbTB0QVc>; Thu, 27 Feb 2003 11:21:32 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:37650 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S265414AbTB0QVc>; Thu, 27 Feb 2003 11:21:32 -0500
Date: Thu, 27 Feb 2003 16:31:28 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Dominik Kubla <dominik@kubla.de>, Kasper Dupont <kasperd@daimi.au.dk>,
       Miles Bader <miles@gnu.org>, DervishD <raul@pleyades.net>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: About /etc/mtab and /proc/mounts
Message-ID: <20030227163128.A7312@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Horst von Brand <vonbrand@inf.utfsm.cl>,
	Dominik Kubla <dominik@kubla.de>,
	Kasper Dupont <kasperd@daimi.au.dk>, Miles Bader <miles@gnu.org>,
	DervishD <raul@pleyades.net>,
	Linux-kernel <linux-kernel@vger.kernel.org>
References: <200302271012.02283.dominik@kubla.de> <200302271600.h1RG0Cdh011948@eeyore.valparaiso.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200302271600.h1RG0Cdh011948@eeyore.valparaiso.cl>; from vonbrand@inf.utfsm.cl on Thu, Feb 27, 2003 at 01:00:12PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2003 at 01:00:12PM -0300, Horst von Brand wrote:
> I fail to see any significant difference to /proc/mounts (possibly expanded).
> Sure, /proc is the wrong place for this kind of stuff, but...

In this rare case it's not.  /proc/mounts in fact is only a link
to /proc/self/mounts and that is needed because wecan have per-process
private namespace in Linux now.

(of course this drives the traditional /etc/mtab completly useless)
