Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269688AbTGaVW3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 17:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269736AbTGaVW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 17:22:28 -0400
Received: from holomorphy.com ([66.224.33.161]:31705 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S269688AbTGaVW1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 17:22:27 -0400
Date: Thu, 31 Jul 2003 14:23:42 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Frederick, Fabian" <Fabian.Frederick@prov-liege.be>
Cc: "Linux-Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: Re: pid_max ?
Message-ID: <20030731212342.GE15452@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Frederick, Fabian" <Fabian.Frederick@prov-liege.be>,
	"Linux-Kernel (E-mail)" <linux-kernel@vger.kernel.org>
References: <D9B4591FDBACD411B01E00508BB33C1B01BF8C95@mesadm.epl.prov-liege.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D9B4591FDBACD411B01E00508BB33C1B01BF8C95@mesadm.epl.prov-liege.be>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 30, 2003 at 09:53:12AM +0200, Frederick, Fabian wrote:
> 	I was looking at pid.c file and can't understand pid_max usage.
> It's defined as integer (signed) =PID_MAX_DEFAULT (which is 0x8000 (on old
> arch, integer max positive value isn't 32767 ? so 0x8000 -> -32768).
> 	In alloc_pidmap, 'if (pid>=pid_max)' should be in that case always
> true so pid=RESERVED_PIDS which is 300 (?).Why not use pid>PID_MAX_DEFAULT
> there and forget the pid_max definition ? and why do we have that '300'
> value ?

It's to avoid trying to allocate from the range of pid's typically used
by kernel threads and system daemons after bootup. There are no hard
dependencies on it, it's merely "traditional pidspace layout".


-- wli
