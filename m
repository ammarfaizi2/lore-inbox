Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266166AbUGARPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266166AbUGARPS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 13:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266115AbUGARPR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 13:15:17 -0400
Received: from msgdirector1.onetel.net.uk ([212.67.96.148]:57367 "EHLO
	msgdirector1.onetel.net.uk") by vger.kernel.org with ESMTP
	id S266166AbUGARPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 13:15:13 -0400
From: Chris Lingard <chris@ukpost.com>
To: Arkadiusz Patyk <areqlkl@areq.eu.org>
Subject: Re: initramfs and kernel  2.6.7
Date: Thu, 1 Jul 2004 18:15:09 +0100
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <r236e0tp11ek1q0rh5912e423mc78qio5g@4ax.com>
In-Reply-To: <r236e0tp11ek1q0rh5912e423mc78qio5g@4ax.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407011815.09236.chris@ukpost.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 June 2004 19:55, Arkadiusz Patyk wrote:
> Hi,
>
> I 'am trying to launch linux kernel 2.6.7 with initramfs.

> kernel vmlinuz-2.6.7-1
> append initrd=initramfs_data.cpio.gz root=/dev/ram0 init=/linuxrc

The append line is unnecessary

First, your script with your initramfs should be called init and
not linuxrc :-(

Assuming that you are creating the cpio with --format=newc,
you should copy your initramfs.cpio.gz to:
linux-2.6.7/usr/initramfs_data.cpio.gz

Make the kernel, boot the kernel; and the initramfs will be mounted as
root, and control given to the init script.

Chris Lingard
