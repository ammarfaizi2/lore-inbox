Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263343AbTDSENL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 00:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263348AbTDSENL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 00:13:11 -0400
Received: from holomorphy.com ([66.224.33.161]:31372 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263343AbTDSENK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 00:13:10 -0400
Date: Fri, 18 Apr 2003 21:24:39 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "J. Hidding" <J.Hidding@student.rug.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.67-mm4] Can't open pty's
Message-ID: <20030419042439.GD12469@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"J. Hidding" <J.Hidding@student.rug.nl>,
	linux-kernel@vger.kernel.org
References: <web-6774367@mail.rug.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <web-6774367@mail.rug.nl>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 19, 2003 at 05:26:17AM +0200, J. Hidding wrote:
> Xterm (nor any other VT) won't run on my freshly compiled 
> 2.5.67-mm4 kernel. It says:
> --
> xterm: Error 32, errno 2: No such file or directory
> Reason: get_pty: not enough ptys
> --

Your problem is:
#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=64

Increase CONFIG_UNIX98_PTY_COUNT to 2048 or thereabouts.


-- wli
