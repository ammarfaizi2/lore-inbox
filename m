Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265366AbTFFHTj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 03:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265371AbTFFHTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 03:19:39 -0400
Received: from AMarseille-201-1-3-239.w193-253.abo.wanadoo.fr ([193.253.250.239]:18983
	"EHLO gaston") by vger.kernel.org with ESMTP id S265366AbTFFHTi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 03:19:38 -0400
Subject: Re: [2.5.70][PPC] Small change to config
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Daniele Pala <dandario@libero.it>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <19040101015154.GA346@libero.it>
References: <19040101015154.GA346@libero.it>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054884786.766.64.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 06 Jun 2003 09:33:06 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1969-12-31 at 23:59, Daniele Pala wrote:
> Since "control" and "platinum" display support doesn't compile if /dev/nvram suppor is selected as a module, here's this
> small patch. The problem is that the suppor for /dev/nvram is asked after the "control" and "platinum" support...
> Cheers,

The proper fix is for those drivers to use the low level nvram access
functions and have those always built in on pmac, the config option
beeing only useful for the char device wrapper...

Anyway, pmac stuff in 2.5 is about to be significantly changed once
I'm done with the move to the new driver model, hopefully, I'll fix
those things along.

Ben.

