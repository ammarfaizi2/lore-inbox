Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750859AbWCVMcY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbWCVMcY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 07:32:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750862AbWCVMcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 07:32:24 -0500
Received: from smtp-103-wednesday.nerim.net ([62.4.16.103]:56581 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1750855AbWCVMcY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 07:32:24 -0500
Date: Wed, 22 Mar 2006 13:32:49 +0100
From: Jean Delvare <khali@linux-fr.org>
To: "Mark M. Hoffman" <mhoffman@lightlink.com>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org,
       Etienne Lorrain <etienne_lorrain@yahoo.fr>
Subject: Re: [PATCH 2.6.16-rc6] i2c: require type parameter for i2c-parport
 and i2c-parport-light
Message-Id: <20060322133249.7cca1de4.khali@linux-fr.org>
In-Reply-To: <20060317035856.GB3446@jupiter.solarsys.private>
References: <20060316035916.GA10675@jupiter.solarsys.private>
	<3ZH07HE0.1142498811.4526410.khali@localhost>
	<20060317035616.GA3446@jupiter.solarsys.private>
	<20060317035856.GB3446@jupiter.solarsys.private>
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

> This patch forces the user to specify what type of adapter is present when
> loading i2c-parport or i2c-parport-light.  If none is specified, the driver
> init simply fails - instead of assuming adapter type 0.
> 
> This alleviates the sometimes lengthy boot time delays which can be caused
> by accidentally building one of these into a kernel along with several i2c
> slave drivers that have lengthy probe routines (e.g. hwmon drivers).
> 
> Kconfig and documentation updated accordingly.

Good patch, thanks, I've applied it. The only change I made is:

> + * (type=5) Analog Devices evaluation boards: ADM1025, ADM103[01]

I expanded it to "ADM1025, ADM1030, ADM1031", because I think it's
important to be able to just grep chip names in the documentation files
(or source code, for that matter.)

Thanks,
-- 
Jean Delvare
