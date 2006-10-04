Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161581AbWJDQn2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161581AbWJDQn2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 12:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161587AbWJDQn1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 12:43:27 -0400
Received: from smtp-out001.kontent.com ([81.88.40.215]:35769 "EHLO
	smtp-out.kontent.com") by vger.kernel.org with ESMTP
	id S1161581AbWJDQn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 12:43:26 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: error to be returned while suspended
Date: Wed, 4 Oct 2006 18:34:57 +0200
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <200610031323.00547.oliver@neukum.org> <20061004111933.GA8297@elf.ucw.cz>
In-Reply-To: <20061004111933.GA8297@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610041834.57639.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 4. Oktober 2006 13:19 schrieb Pavel Machek:
> On Tue 2006-10-03 13:23:00, Oliver Neukum wrote:
> > Hi,
> > 
> > which error should a character device return if a read/write cannot be
> > serviced because the device is suspended? Shouldn't there be an error
> > code specific to that?
> 
> If you are talking system suspend, then userspace should not run while
> devices are suspended.
> 
> If you are talking runtime suspend, you should probably just wake the
> device up on first access.

Do you really think a device driver should override an explicitely
selected power state?

	Regards
		Oliver
