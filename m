Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263353AbTDGI7r (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 04:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263354AbTDGI7r (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 04:59:47 -0400
Received: from dspnet.fr.eu.org ([62.73.5.179]:13832 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S263353AbTDGI7p (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 04:59:45 -0400
Date: Mon, 7 Apr 2003 11:11:20 +0200
From: Olivier Galibert <galibert@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new syscall: flink
Message-ID: <20030407091120.GA50075@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	linux-kernel@vger.kernel.org
References: <Pine.BSO.4.44.0304062250250.9407-100000@kwalitee.nolab.conman.org> <b6qruf$elf$1@cesium.transmeta.com> <b6r9cv$jof$1@news.cistron.nl> <20030407081800.GA48052@dspnet.fr.eu.org> <20030407043555.G13397@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030407043555.G13397@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 07, 2003 at 04:35:56AM -0400, Jakub Jelinek wrote:
> There is at most one path associated with an opened file - d_path on
> file->f_dentry. If a fd has no path, don't permit flink().
> Alternatively, flink() could have 3 arguments, 2 like link and an opened
> fd, which would atomically do if fd describes the same object as buf,
> link buf to newname.

That breaks one of the main uses, creating with open a temporary file
in /tmp, unlinking it, then later hooking it up somewhere else in the
filesystem.

  OG.

