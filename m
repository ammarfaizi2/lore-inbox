Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315779AbSGPLnD>; Tue, 16 Jul 2002 07:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315806AbSGPLnC>; Tue, 16 Jul 2002 07:43:02 -0400
Received: from gate.in-addr.de ([212.8.193.158]:44815 "HELO mx.in-addr.de")
	by vger.kernel.org with SMTP id <S315779AbSGPLnB>;
	Tue, 16 Jul 2002 07:43:01 -0400
Date: Tue, 16 Jul 2002 13:47:47 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Joerg Schilling <schilling@fokus.gmd.de>, James.Bottomley@steeleye.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
Message-ID: <20020716114747.GL18432@marowsky-bree.de>
References: <200207161128.g6GBSJPE021316@burner.fokus.gmd.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200207161128.g6GBSJPE021316@burner.fokus.gmd.de>
User-Agent: Mutt/1.4i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-07-16T13:28:19,
   Joerg Schilling <schilling@fokus.gmd.de> said:

> Why should the character interface be connected to the block layer?
> This would contradict UNIX rules.

How would it? At some layer, the two are merged anyway (for example, at least
on disk you'll have blocks again). Doing it up high means more unified code
below.

> AFAIK, tagged command queuing is a SCSI specific property, why should this
> be part of a generif block layer?

That is not true. Late IDE also has this, and systems like drbd - which
currently uses a quite clever heuristic to deduce barriers - could also
utilize this input.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
Immortality is an adequate definition of high availability for me.
	--- Gregory F. Pfister

