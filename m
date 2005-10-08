Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161019AbVJHATE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161019AbVJHATE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 20:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161020AbVJHATD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 20:19:03 -0400
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:56297 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1161019AbVJHATB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 20:19:01 -0400
From: Grant Coady <grant_lkml@dodo.com.au>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, stefanr@s5r6.in-berlin.de,
       bcollins@debian.org
Subject: Re: [patch 1/7] ieee1394/sbp2: fixes for hot-unplug and module unloading
Date: Sat, 08 Oct 2005 10:18:21 +1000
Organization: http://bugsplatter.mine.nu/
Message-ID: <004ek192bmh6t6ei08cpnusf8dmpi0dk6d@4ax.com>
References: <20051007234348.631583000@press.kroah.org> <20051007235353.GA23111@kroah.com> <20051007235422.GB23111@kroah.com>
In-Reply-To: <20051007235422.GB23111@kroah.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Oct 2005 16:54:22 -0700, Greg KH <gregkh@suse.de> wrote:

>+static inline int sbp2util_node_is_available(struct scsi_id_instance_data *scsi_id)
>+{
>+	return scsi_id && scsi_id->ne && !scsi_id->ne->in_limbo;
>+}
>+
> 
^^^^^ How did that 0x0c character sneak in there?

Grant.
