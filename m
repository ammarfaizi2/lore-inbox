Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318869AbSIDOuL>; Wed, 4 Sep 2002 10:50:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318888AbSIDOuL>; Wed, 4 Sep 2002 10:50:11 -0400
Received: from gate.in-addr.de ([212.8.193.158]:24071 "HELO mx.in-addr.de")
	by vger.kernel.org with SMTP id <S318869AbSIDOuK>;
	Wed, 4 Sep 2002 10:50:10 -0400
Date: Wed, 4 Sep 2002 16:49:38 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: writing OOPS/panic info to nvram?
Message-ID: <20020904144938.GA1106@marowsky-bree.de>
References: <E471FA7E-C00E-11D6-A20D-000393911DE2@sara.nl> <20020904140856.GA1949@werewolf.able.es> <1031149539.2788.120.camel@irongate.swansea.linux.org.uk> <20020904144154.GE1949@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20020904144154.GE1949@werewolf.able.es>
User-Agent: Mutt/1.4i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-09-04T16:41:54,
   "J.A. Magallon" <jamagallon@able.es> said:

> Ah, ther is no way to write raw blocks at a very low level to disk...??

Not reliably; you _know_ your infrastructure has crashed, otherwise you
wouldn't be inside the crash dump handler ;), so you can't possibly trust the
normal block layer to write the crash dump (and not write it over your salary
and customer database).

Parts of this could probably be circumvented by a checksum of the code which
is computed at boot time and checked before the crashdump takes place, but this doesn't deal with a crashed SCSI driver.

A network dump is much safer, though I would suggest running it over a
dedicated card / driver combo and on a special ethernet protocol, because you
might have lost your IP configuration...


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
Immortality is an adequate definition of high availability for me.
	--- Gregory F. Pfister

