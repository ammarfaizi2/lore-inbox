Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266107AbUBGBgv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 20:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266243AbUBGBgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 20:36:51 -0500
Received: from inet-mail1.oracle.com ([148.87.2.201]:7876 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id S266107AbUBGBgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 20:36:38 -0500
Date: Fri, 6 Feb 2004 17:35:53 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Matthias Urlichs <smurf@smurf.noris.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VFS locking: f_pos thread-safe ?
Message-ID: <20040207013553.GW4902@ca-server1.us.oracle.com>
Mail-Followup-To: Matthias Urlichs <smurf@smurf.noris.de>,
	linux-kernel@vger.kernel.org
References: <20040206041223.A18820@almesberger.net> <20040206183746.GR4902@ca-server1.us.oracle.com> <pan.2004.02.06.19.05.47.617416@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pan.2004.02.06.19.05.47.617416@smurf.noris.de>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-White-List-Member: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 06, 2004 at 08:05:48PM +0100, Matthias Urlichs wrote:
> thread A reads M @N   thread B reads M @N     file pointer ends up as N+M
> thread A reads M @N   thread B reads M @M+N   file pointer ends up as N+2M
> thread A reads M @M+N thread B reads M @N     file pointer ends up as N+2M
> 
> With your description,
> thread A reads M @M+N thread B reads M @M+N   file pointer ends up as N+2M

	I didn't mean the last.  I was just writing English, and figured
everyone would know what I meant.  Obviously, the first read() in starts
@M.

Joel

-- 

Life's Little Instruction Book #198

	"Feed a stranger's expired parking meter."

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
