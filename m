Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261444AbTFJTR0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 15:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbTFJTRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 15:17:18 -0400
Received: from holomorphy.com ([66.224.33.161]:27353 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261444AbTFJTQV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 15:16:21 -0400
Date: Tue, 10 Jun 2003 12:29:21 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Rik van Riel <riel@redhat.com>, colin@colina.demon.co.uk,
       linux-kernel@vger.kernel.org
Subject: Re: Maximum swap space?
Message-ID: <20030610192921.GD26348@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Randy.Dunlap" <rddunlap@osdl.org>, Rik van Riel <riel@redhat.com>,
	colin@colina.demon.co.uk, linux-kernel@vger.kernel.org
References: <ltptlqb72n.fsf@colina.demon.co.uk> <Pine.LNX.4.44.0306071827450.24170-100000@chimarrao.boston.redhat.com> <20030610120039.31e8ee47.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030610120039.31e8ee47.rddunlap@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 10, 2003 at 12:00:39PM -0700, Randy.Dunlap wrote:
> So do we know what the 2.4.current and 2.5.current limits are?
> You have used a 20 GB swap partition on 2.4.recent.
> Andrew has used (tested) a 52 GB partition on some unmentioned
> kernel.

I apologize for failing to do a proper wrap-up. AIUI, we have:

(1) both 2.4.x and 2.5.x kernels support swapspaces of up to 64GB in size

(2) 2.4.x supports 64 swapspaces and 2.5.x supports 32 (not reparable)

(3) mkswap(8) needs fixes for creating swapspaces larger than 2GB merged
	back to util-linux; aeb (util-linux maintainer) has publicly
	requested the code be sent back to him for merging, presumably
	with some evidence of its correctness. One of the several distro
	people who are maintaining such patches against mkswap(8) is
	going to send that in.


-- wli
