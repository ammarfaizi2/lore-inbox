Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932419AbWIDHPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419AbWIDHPs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 03:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbWIDHPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 03:15:48 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:48830 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932419AbWIDHPr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 03:15:47 -0400
Date: Mon, 4 Sep 2006 09:11:46 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Josef Sipek <jsipek@cs.sunysb.edu>
cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       hch@infradead.org, akpm@osdl.org, viro@ftp.linux.org.uk
Subject: Re: [PATCH 09/22][RFC] Unionfs: File operations
In-Reply-To: <20060901014818.GJ5788@fsl.cs.sunysb.edu>
Message-ID: <Pine.LNX.4.61.0609040909180.9108@yvahk01.tjqt.qr>
References: <20060901013512.GA5788@fsl.cs.sunysb.edu> <20060901014818.GJ5788@fsl.cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>+	memcpy(&(hidden_file->f_ra), &(file->f_ra),
>+	       sizeof(struct file_ra_state));

-> has precedence over &, so the () are not needed.

>+	if (err != file->f_pos) {
>+		file->f_pos = err;
>+		// ION maybe this?
>+		//      file->f_pos = hidden_file->f_pos;

ION?

>+static int unionfs_file_readdir(struct file *file, void *dirent,
>+				filldir_t filldir)
>+{
>+	int err = -ENOTDIR;
>+	return err;
>+}

{
	return -ENOTDIR;
}




Jan Engelhardt
-- 

-- 
VGER BF report: H 0
