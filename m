Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290818AbSCLXnV>; Tue, 12 Mar 2002 18:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291026AbSCLXnO>; Tue, 12 Mar 2002 18:43:14 -0500
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:28690 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S290818AbSCLXnF>; Tue, 12 Mar 2002 18:43:05 -0500
Date: Tue, 12 Mar 2002 23:42:56 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.6 scsi DMA mapping and compilation fixes (not yet working)
Message-ID: <20020312234256.B13558@flint.arm.linux.org.uk>
In-Reply-To: <200203122056.MAA05893@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200203122056.MAA05893@adam.yggdrasil.com>; from adam@yggdrasil.com on Tue, Mar 12, 2002 at 12:56:21PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2002 at 12:56:21PM -0800, Adam J. Richter wrote:
> 		o The NCR53c80-based drivers (according to Alan Cox, there
> 		  is a new driver in the 2.4.x tree, and I don't want to
> 		  add a port of that driver to this already huge patch).

I believe changes to NCR53c80 were recently reverted back because
these "fixes" lead to massive data corruption.  It is preferable
that the driver remains unbuildable, and therefore doesn't cause
data corruption than to be buildable and case data corruption.

Alan has always advocated taking the 2.4 driver as an important
first step in fixing it for 2.5 - this provides a sound base for the
2.5 fixes to be built upon.  Not doing this just makes whoevers job
to really fix the driver harder.

Hint: kernel programming is not about getting things to build.  It's
about making this work properly.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

