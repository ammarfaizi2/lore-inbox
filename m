Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266825AbUBMI6S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 03:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266826AbUBMI6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 03:58:18 -0500
Received: from xenon2.um.es ([155.54.212.101]:58829 "EHLO smtp.um.es")
	by vger.kernel.org with ESMTP id S266825AbUBMI5z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 03:57:55 -0500
Date: Fri, 13 Feb 2004 09:28:13 +0100 (CET)
From: Juan Piernas Canovas <piernas@ditec.um.es>
To: Jon Burgess <lkml@jburgess.uklinux.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext2/3 performance regression in 2.6 vs 2.4 for small interleaved
 writes
In-Reply-To: <402BE01E.2010506@jburgess.uklinux.net>
Message-ID: <Pine.LNX.4.44.0402130920240.20128-100000@ditec.um.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Feb 2004, Jon Burgess wrote:

[snip]

> >You might be able to improve things significantly on ext2 by increasing
> >EXT2_DEFAULT_PREALLOC_BLOCKS by a lot - make it 64 or 128.  I don't recall
> >anyone trying that.
> >  
> >
> I'll give it a go.

I think that a better choise for Ext2 and Ext3 is to put each stream 
in a different directory (but that only makes sense if those directories 
are in different groups). In that way, file blocks will not be interleaved on 
disk, which is the problem. Try this, if you can, and let us know your 
results.

Regards,

	Juan.

[snip]
> 
>     Jon
> 

-- 
D. Juan Piernas Cánovas
Departamento de Ingeniería y Tecnología de Computadores
Facultad de Informática. Universidad de Murcia
Campus de Espinardo - 30080 Murcia (SPAIN)
Tel.: +34968367657    Fax: +34968364151
email: piernas@ditec.um.es
PGP public key:
http://pgp.rediris.es:11371/pks/lookup?search=piernas%40ditec.um.es&op=index

*** Por favor, envíeme sus documentos en formato texto, HTML, PDF o PostScript :-) ***

