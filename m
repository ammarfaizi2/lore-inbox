Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263892AbTH1KQV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 06:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263891AbTH1KI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 06:08:56 -0400
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:55972 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S263884AbTH1KIZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 06:08:25 -0400
Date: Thu, 28 Aug 2003 12:08:21 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Lockless file reading
Message-ID: <20030828100821.GB5040@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <1061987837.1455.107.camel@hurina> <200308271442.48672.martin.konold@erfrakon.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308271442.48672.martin.konold@erfrakon.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Aug 2003, Martin Konold wrote:

> Am Wednesday 27 August 2003 02:37 pm schrieb Timo Sirainen:
> 
> Hi,
> 
> > The question is what can happen if I read() a file that's being
> > simultaneously updated by a write() in another process?
> 
> The behaviour is undefined.
>  
> > 123 over XXX, is it possible that read() returns 1X3 in some conditions?
> 
> Yes. The actual order stuff is written to the disk is not guaranteed.

What has the disk block write order got to do with it? It's not as
though write() would be cached but read() see the raw disk.

-- 
Matthias Andree
