Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262870AbTI2HXn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 03:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262861AbTI2HV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 03:21:57 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46283 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262860AbTI2HV3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 03:21:29 -0400
Date: Mon, 29 Sep 2003 08:21:27 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Oliver Tennert <tennert@science-computing.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why Sysrq+k does not offer a trusted path
Message-ID: <20030929072127.GN7665@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.44.0309290836460.16991-100000@picard.science-computing.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309290836460.16991-100000@picard.science-computing.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 29, 2003 at 08:53:59AM +0200, Oliver Tennert wrote:
> Thus it is a more secure way to offer a real SAK.
> 
> Or am I missing a very important point?

Scanning through the file descriptor tables of processes does not catch
every opened file out there.  For trivial example consider attaching an
open file to SCM_RIGHTS datagram and sending it to yourself.  Then close
the original descriptor.   Later you will be able to receive the datagram
and get your opened file back.
