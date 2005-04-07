Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262426AbVDGKbt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262426AbVDGKbt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 06:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262421AbVDGKbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 06:31:49 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:9118 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262424AbVDGKb1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 06:31:27 -0400
Date: Thu, 7 Apr 2005 11:31:23 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] Use proper seq_file api for /proc/scsi/scsi
Message-ID: <20050407103123.GB9586@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Hannes Reinecke <hare@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	SCSI Mailing List <linux-scsi@vger.kernel.org>
References: <42550173.1040503@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42550173.1040503@suse.de>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2005 at 11:46:27AM +0200, Hannes Reinecke wrote:
> Hi all,
> 
> /proc/scsi/scsi currently has a very dumb implementation of the seq_file
> api which causes 'cat /proc/scsi/scsi' to return with -ENOMEM when a
> large amount of devices are connected.

/proc/scsi/scsi is deprecated and even only compiled in if
"legacy /proc/scsi/ support" is enabled.  Please move over to lssci which
is using sysfs ASAP.

