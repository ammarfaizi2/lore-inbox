Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266948AbTBQJoe>; Mon, 17 Feb 2003 04:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266961AbTBQJoe>; Mon, 17 Feb 2003 04:44:34 -0500
Received: from gate.in-addr.de ([212.8.193.158]:15108 "HELO mx.in-addr.de")
	by vger.kernel.org with SMTP id <S266948AbTBQJod>;
	Mon, 17 Feb 2003 04:44:33 -0500
Date: Mon, 17 Feb 2003 10:52:15 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: Patrick Mansfield <patmans@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: Accessing the same disk via multiple channels
Message-ID: <20030217095215.GF9034@marowsky-bree.de>
References: <20030213194917.GA8479@quadpro.stupendous.org> <E18jS75-0007na-00@calista.inka.de> <20030214100316.GA3422@marowsky-bree.de> <20030214140155.A5344@jose.vato.org> <20030214153747.A28502@beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030214153747.A28502@beaverton.ibm.com>
User-Agent: Mutt/1.4i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2003-02-14T15:37:47,
   Patrick Mansfield <patmans@us.ibm.com> said:

> Generic multi-path without the lower levels knowing anything can waste a
> lot of resources. For example, for each extra path to a block device
> (disk) we end up with an extra sd plus associated data structures, and an
> extra scsi_device including multiple request queues.

I think these somehow still need to be exposed so that userspace can do
per-path diagnostics; unless you also want to move this into the kernel space,
which I'm not sure about.

What we really need is better error handling and escalation so that a higher
layer actually has a chance at really well done recovery and retrying.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
Principal Squirrel 
SuSE Labs - Research & Development, SuSE Linux AG
  
"If anything can go wrong, it will." "Chance favors the prepared (mind)."
  -- Capt. Edward A. Murphy            -- Louis Pasteur
