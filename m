Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422649AbWBVSAe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422649AbWBVSAe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 13:00:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422651AbWBVSAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 13:00:34 -0500
Received: from tomts25-srv.bellnexxia.net ([209.226.175.188]:39854 "EHLO
	tomts25-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1422647AbWBVSAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 13:00:33 -0500
Message-ID: <43FCA686.5020508@torque.net>
Date: Wed, 22 Feb 2006 12:59:34 -0500
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: lsscsi-0.17 released
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
>>/sys/class/scsi_device/<hcil>/device/block symlink
>>changed to ".../block:sd<x>" breaking lsscsi 0.16 (and
>>earlier) and sg_map26 (in sg3_utils).

> It was changed as there would be more than one "block" symlink in a
> device's directory if more than one block device was attached to a
> single struct device.  For example, ub and multi-lun devices (there were
> other reports of this happening for scsi devices too at the time from
> what I remember.)

A "scsi_device" is a logical unit, hence the "l" at
the end of the "<hcil>" acronym in the above path.
So it wasn't broken. However there is some fuzziness
in this area, for example the term "scsi_device".

Doug Gilbert
