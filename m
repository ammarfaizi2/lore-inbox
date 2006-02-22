Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751385AbWBVScY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbWBVScY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 13:32:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbWBVScY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 13:32:24 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:47064
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1750763AbWBVScX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 13:32:23 -0500
Date: Wed, 22 Feb 2006 10:32:26 -0800
From: Greg KH <greg@kroah.com>
To: Matthew Wilcox <matthew@wil.cx>, Douglas Gilbert <dougg@torque.net>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: lsscsi-0.17 released
Message-ID: <20060222183226.GA12542@kroah.com>
References: <43FBA4CD.6000505@torque.net> <m34q2r93q2.fsf@merlin.emma.line.org> <43FC7CCB.4090508@torque.net> <20060222160602.GB17473@merlin.emma.line.org> <43FC90E4.10805@torque.net> <20060222163426.GG28587@parisc-linux.org> <20060222171438.GA20272@kroah.com> <20060222180015.GB20880@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060222180015.GB20880@merlin.emma.line.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 07:00:15PM +0100, Matthias Andree wrote:
> On Wed, 22 Feb 2006, Greg KH wrote:
> 
> > It was changed as there would be more than one "block" symlink in a
> > device's directory if more than one block device was attached to a
> > single struct device.  For example, ub and multi-lun devices (there were
> > other reports of this happening for scsi devices too at the time from
> > what I remember.)
> 
> OK, just post an announcement to l-k when sysfs has stabilized enough to
> be worth bothering.

Um, this was a "bugfix".  The kernel was creating multiple symlinks with
the same name, in the same directory, pointing to different locations.
How do you expect us to fix that in a format that does not change the
name of the symlink?

People sure are grumpy this morning...

greg k-h
