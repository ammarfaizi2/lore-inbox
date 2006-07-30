Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751421AbWG3W3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbWG3W3w (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 18:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751429AbWG3W3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 18:29:52 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:64937 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751421AbWG3W3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 18:29:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:to:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from;
        b=iWFDLvcyKZYuxXXBkBYGi7IwoGkmmzZn5pCjW7Jy7AnkVSMDIbH8pX9dqkX9fme3GOeCQHCgP3kRnxgD0n2kCtaoEiQAJ2lZfPDladWwjyQClnfUEhrhDIhS8kP0850X/hPn9BnH1+JHapHXGqhMSnb2pE1CvX957vo5zp8+L9I=
Date: Mon, 31 Jul 2006 00:28:14 +0200
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Question about "Not Ready" SCSI error
Message-ID: <20060730222814.GA17856@leiferikson.dystopia.lan>
Mail-Followup-To: Linux Kernel <linux-kernel@vger.kernel.org>
References: <20060730181014.GA13456@oscar.prima.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060730181014.GA13456@oscar.prima.de>
User-Agent: mutt-ng/devel-r804 (GNU/Linux)
From: Johannes Weiner <hnazfoo@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Jul 30, 2006 at 08:10:19PM +0200, Patrick Mau wrote:
> Jul 30 15:51:30 tony kernel: sd 0:0:0:0: Device not ready: <6>: Current: sense key=0x2
> Jul 30 15:51:30 tony kernel: ASC=0x4 ASCQ=0x2
> Jul 30 15:51:30 tony kernel: end_request: I/O error, dev sda, sector 617358
> 
> Google revealed[1] that the drive is waiting for a START UNIT command,
> but it seems that the kernel is not attempting to spin up the drive
> again. 

Further looking at all the involved struct's, I found that it might be
possible to call the driver's rescan function explicitely in the occured
case.

Unfortunatly I don't have the appropriate hardware to test this :(

Hannes
