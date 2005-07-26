Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261932AbVGZQeE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbVGZQeE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 12:34:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbVGZQeB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 12:34:01 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:19984 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261932AbVGZQds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 12:33:48 -0400
Date: Tue, 26 Jul 2005 17:33:39 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "V. ANANDA KRISHNAN" <mansarov@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, gregkh@suse.de
Subject: Re: serial pci driver
Message-ID: <20050726173339.A10838@flint.arm.linux.org.uk>
Mail-Followup-To: "V. ANANDA KRISHNAN" <mansarov@us.ibm.com>,
	linux-kernel@vger.kernel.org, gregkh@suse.de
References: <1122393690.3524.11.camel@siliver.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1122393690.3524.11.camel@siliver.austin.ibm.com>; from mansarov@us.ibm.com on Tue, Jul 26, 2005 at 11:01:30AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2005 at 11:01:30AM -0500, V. ANANDA KRISHNAN wrote:
>  Can some one help me to understand the function of reg_shift in the
> pci_board structure and how it is used?  Thanks for your help.

It represents the log2 byte spacing between each register of the
serial port.  Some serial ports are wired up such that the registers
are sparsely mapped into memory space, so reg_shift tells the serial
driver about this.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
