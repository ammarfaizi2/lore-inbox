Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261394AbRFFUnC>; Wed, 6 Jun 2001 16:43:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261296AbRFFUmx>; Wed, 6 Jun 2001 16:42:53 -0400
Received: from i1516.vwr.wanadoo.nl ([194.134.213.242]:18048 "HELO
	localhost.localdomain") by vger.kernel.org with SMTP
	id <S261336AbRFFUmp>; Wed, 6 Jun 2001 16:42:45 -0400
Date: Wed, 6 Jun 2001 22:42:53 +0200
From: Remi Turk <remi@a2zis.com>
To: Mikael Pettersson <mikpe@csd.uu.se>, alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.5-ac8 hardlocks when going to standby
Message-ID: <20010606224253.A964@localhost.localdomain>
Mail-Followup-To: Mikael Pettersson <mikpe@csd.uu.se>,
	alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <200106061310.PAA14058@harpo.it.uu.se> <20010606190309.A893@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010606190309.A893@localhost.localdomain>; from remi@a2zis.com on Wed, Jun 06, 2001 at 07:03:09PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2001 at 07:03:09PM +0200, Remi Turk wrote:
> 
> By applying the following patch (lookalike)?
> 
> arch/i386/kernel/apm.c:send_event():
> 
> 	case APM_SYS_SUSPEND:
> 	case APM_CRITICAL_SUSPEND:
> 	case APM_USER_SUSPEND:
> +	case APM_USER_STANDBY:
> +	case APM_SYS_STANDBY:
> 		/* map all suspends to ACPI D3 */
> 		if (pm_send_all(PM_SUSPEND, (void
> 			*)3)) {

Well, I tried this one (did I understand correctly wat
you meant???) and it didn't make any difference.

-- 
Linux 2.4.6-pre1 #1 Wed Jun 6 18:25:37 CEST 2001
