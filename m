Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263867AbUDFP4M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 11:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261779AbUDFP4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 11:56:12 -0400
Received: from ns.suse.de ([195.135.220.2]:49854 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263897AbUDFP4H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 11:56:07 -0400
To: Juergen Salk <juergen.salk@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strip whitespace from EXTRAVERSION?
References: <20040406144709.GC16564@oest181.str.klinik.uni-ulm.de>
From: Andreas Schwab <schwab@suse.de>
X-Yow: YOW!!  Everybody out of the GENETIC POOL!
Date: Tue, 06 Apr 2004 17:56:05 +0200
In-Reply-To: <20040406144709.GC16564@oest181.str.klinik.uni-ulm.de> (Juergen
 Salk's message of "Tue, 6 Apr 2004 16:47:09 +0200")
Message-ID: <jeu0zx5cdm.fsf@sykes.suse.de>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Juergen Salk <juergen.salk@gmx.de> writes:

> --- Makefile-orig       Tue Apr  6 14:13:06 2004
> +++ Makefile    Tue Apr  6 14:45:29 2004
> @@ -3,6 +3,7 @@
>  SUBLEVEL = 25
>  EXTRAVERSION =
>
> +EXTRAVERSION:=$(shell echo $(EXTRAVERSION) | sed -e 's/[ 	]//g')

EXTRAVERSION := $(strip $(EXTRAVERSION))

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
