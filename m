Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263591AbTLXMIF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 07:08:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263596AbTLXMIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 07:08:05 -0500
Received: from pooh.lsc.hu ([195.56.172.131]:27845 "EHLO pooh.lsc.hu")
	by vger.kernel.org with ESMTP id S263591AbTLXMID (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 07:08:03 -0500
Date: Wed, 24 Dec 2003 12:53:42 +0100
From: GCS <gcs@lsc.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Peter Osterlund <petero2@telia.com>,
       Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: 2.6.0-mm1
Message-ID: <20031224115342.GA10350@lsc.hu>
References: <20031224095921.GA8147@lsc.hu> <20031224033200.0763f2a2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <20031224033200.0763f2a2.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
X-Operating-System: GNU/Linux
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 24, 2003 at 03:32:00AM -0800, Andrew Morton <akpm@osdl.org> wrote:
> I bit of grepping tells us that CONFIG_USB_STORAGE turns on CONFIG_SCSI.
 Thanks! Never throught. I could come up with this:
find . -name Kconfig| xargs grep --colour 'depends.* SCSI'
(Execute in the kernel tree, and replace SCSI with whatever you like;
may help others with similar questions).

> Peter or Dmitry may be able to tell us.
 IMHO it's either:
serio-04-synaptics-cleanup.patch
serio-06-synaptics-use-reconnect.patch
synaptics-powerpro-fix.patch
serio-pm-fix.patch
input-02-add-psmouse_proto.patch (?)
input-05-psmouse-fixes.patch
input-07-remove-synaptics-config-option.patch (maybe?)
input-08-synaptics-protocol-discovery.patch

Thus meanwhile I try to revert them. Anyway, as -mm1 is already bigger,
is it possible that you release 2.6.1 in this year with some/most of the
fixes in mm1?

GCS
