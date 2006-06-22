Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161109AbWFVNVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161109AbWFVNVv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 09:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161110AbWFVNVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 09:21:51 -0400
Received: from mx1.redhat.com ([66.187.233.31]:21665 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161109AbWFVNVu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 09:21:50 -0400
Date: Thu, 22 Jun 2006 14:21:44 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, mbroz@redhat.com
Subject: Re: [PATCH 01/15] dm: support ioctls on mapped devices
Message-ID: <20060622132144.GR19222@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	mbroz@redhat.com
References: <20060621193121.GP4521@agk.surrey.redhat.com> <20060621205206.35ecdbf8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060621205206.35ecdbf8.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2006 at 08:52:06PM -0700, Andrew Morton wrote:
> I don't understand that.  We're taking an ioctl against a dm device and
> we're passing it through to an underlying device?  Or something else?
 
Indeed.  The motivation behind this came from multipath: people want to
issue certain types of ioctls directly against a dm multipath device and
have them pass through one of the paths to the underlying device.
(Otherwise they'd need a knowledge of dm internals to poke around the tree
of dm devices and probe path statuses to determine the correct path(s) to
use - effectively implementing 'multipath' ioctls themselves from userspace
with unavoidable races.)

Alasdair
-- 
agk@redhat.com
