Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262569AbTLJMAQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 07:00:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262729AbTLJMAQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 07:00:16 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:5181 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP id S262569AbTLJMAN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 07:00:13 -0500
Date: Wed, 10 Dec 2003 13:59:57 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: linux-kernel@vger.kernel.org
Subject: Getting file offsets for open files of a process?
Message-ID: <20031210115957.GH1524@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lsof has this option:

       -o       This option directs lsof to display  file  offset
                at all times.  It causes the SIZE/OFF output col­
                umn title to be changed to OFFSET.

but the source contains

#define	OFFTST_STAT	0		/* Linux lsof can't report offsets */

That information is not available in /proc either.

(I'm not sure if the older, non-/proc based lsof version supported this on
linux. Newest lsof has the non-/proc linux mode removed, and I can't find
the old source anymore.)

Is there any way of getting this information in linux?

I suppose Solaris and maybe some others export this information via /proc?

 
-- v --

v@iki.fi
