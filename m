Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965171AbWJXUOF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965171AbWJXUOF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 16:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965173AbWJXUOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 16:14:04 -0400
Received: from moutng.kundenserver.de ([212.227.126.183]:14836 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S965171AbWJXUOD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 16:14:03 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Michael Holzheu <HOLZHEU@de.ibm.com>
Subject: Re: How to document dimension units for virtual files?
Date: Tue, 24 Oct 2006 22:13:55 +0200
User-Agent: KMail/1.9.5
Cc: Ingo Oeser <ioe-lkml@rameria.de>, linux-kernel@vger.kernel.org,
       mschwid2@de.ibm.com
References: <OFA94CF0D3.C5318A12-ON42257211.004B4AC4-42257211.004E4728@de.ibm.com>
In-Reply-To: <OFA94CF0D3.C5318A12-ON42257211.004B4AC4-42257211.004E4728@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610242213.56149.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 24 October 2006 16:15, Michael Holzheu wrote:
> If you want to export data to userspace via virtual filesystems
> like procfs, sysfs, debugfs etc., the following rules are recommended:
>
> - Export only one value in one virtual file.
> - Data format should be as simple as possible.
> - Use ASCII formated strings, no binary data if possible.
> - If data has dimension units, encode that in the filename.
>   Please use the following suffixes:
>   * kb: Kilobytes
>   * mb: Megabytes
>   * ms: Milliseconds
>   * us: Microseconds
>   * ns: Nanoseconds
>   * ...

For larger units like kb or mb, why bother at all?
You can just make that a 64 bit number and give an exact value.
You should also be sure to use a correct unit, i.e.
KiB for 1024 bytes and kB for 1000 bytes.

	Arnd <><
