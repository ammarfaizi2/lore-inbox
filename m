Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287200AbSBGKWP>; Thu, 7 Feb 2002 05:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287204AbSBGKV4>; Thu, 7 Feb 2002 05:21:56 -0500
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:48646 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S287200AbSBGKVv>; Thu, 7 Feb 2002 05:21:51 -0500
Date: Thu, 7 Feb 2002 10:21:44 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Ed Vance <EdV@macrolink.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: what serial driver restructure is planned?
Message-ID: <20020207102144.B15226@flint.arm.linux.org.uk>
In-Reply-To: <11E89240C407D311958800A0C9ACF7D13A768A@EXCHANGE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <11E89240C407D311958800A0C9ACF7D13A768A@EXCHANGE>; from EdV@macrolink.com on Wed, Feb 06, 2002 at 10:32:11AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2002 at 10:32:11AM -0800, Ed Vance wrote:
> 
> > o Beta       Serial driver restructure              (Russell King)
> 
> Regarding the above line from the 2.5 STATUS report, what is the nature of
> the planned restructuring?  I have a CompactPCI hot swap serial mux card
> that I need to support with hot swap functionality on Linux.  Has anybody
> already worked on issues like locking port names to physical slots, etc.?
> Any basic advice?

You can checkout a copy of the code - see www.arm.linux.org.uk/cvs

It basically started out by pulling 65K worth of the duplicated code out
of various serial drivers.  Its currently moving towards allowing the
input layer to talk to serial devices (needed for things like iPAQ
keyboards and IrDA-based keyboards), as well as allowing things like
USB serial devices to use the core code.  Some people would also like
to see a "serial major" where all serial devices live.
