Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263059AbTCNLwL>; Fri, 14 Mar 2003 06:52:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263060AbTCNLwK>; Fri, 14 Mar 2003 06:52:10 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:47232 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S263059AbTCNLwK>; Fri, 14 Mar 2003 06:52:10 -0500
Date: Fri, 14 Mar 2003 13:02:25 +0100
From: Joern Engel <joern@wohnheim.fh-wedel.de>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Oleg Drokin <green@linuxhacker.ru>, "Randy.Dunlap" <rddunlap@osdl.org>,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       deanna_bonds@adaptec.com
Subject: Re: dpt_i2o.c fix for possibly memory corruption on reset timeout
Message-ID: <20030314120224.GA30034@wohnheim.fh-wedel.de>
References: <20030313182819.GA2213@linuxhacker.ru> <20030313105125.1548d67c.rddunlap@osdl.org> <20030313185628.GA2485@linuxhacker.ru> <200303140921.h2E9Lqu08107@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200303140921.h2E9Lqu08107@Port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 March 2003 11:18:49 +0200, Denis Vlasenko wrote:
> 
> I don't like the whole idea that mem leak is tolerable.
> 
> Can we just add a 4 byte scratch pad status to
> struct _adpt_hba? Let it scribble there...

I've had the same idea, but there might be some pitfalls around.
The problem boils down to the users of the buffer. Is it per-device,
per-process, per-whatever?

Once this is known I'm all for putting the buffer into a per-whatever
data structure. But someone has to understand the driver first. :)

Jörn

-- 
Everything should be made as simple as possible, but not simpler.
-- Albert Einstein
