Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265636AbSLIP3h>; Mon, 9 Dec 2002 10:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265612AbSLIP3h>; Mon, 9 Dec 2002 10:29:37 -0500
Received: from mail-01.med.umich.edu ([141.214.93.149]:24949 "EHLO
	mail-01.med.umich.edu") by vger.kernel.org with ESMTP
	id <S265636AbSLIP3g> convert rfc822-to-8bit; Mon, 9 Dec 2002 10:29:36 -0500
Message-Id: <sdf4725e.038@mail-01.med.umich.edu>
X-Mailer: Novell GroupWise Internet Agent 6.0.2
Date: Mon, 09 Dec 2002 10:36:57 -0500
From: "Nicholas Berry" <nikberry@med.umich.edu>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Need help recovering RAID array after admin error
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>>> "Peter T. Breuer" <ptb@it.uc3m.es> 12/09/02 08:31AM >>>
In article <20021209120431.GB9768@mina.ecs.soton.ac.uk> you wrote:
>    Software RAID-5 does indeed protect against a disk failure.

> Don't worry about it.  Remake the whole array with mkraid --force
> --dangerous-no-resync.  Then mark the really failed disk or its
> replacement  as faulty with raidsetfaulty.  Then take it out with
> raidhotremove, then put it back wit raidhotadd. It'll be resynced
> from the oter two.

Or, as you're using mdadm anyway:

mdadm -A -f /dev/md? <list of disk devices>

Nik


