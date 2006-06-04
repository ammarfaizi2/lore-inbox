Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932286AbWFDXBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932286AbWFDXBd (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 19:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbWFDXBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 19:01:33 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:62068 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932286AbWFDXBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 19:01:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=Kr0ccY0yhI219sfV66XLJjIUScmiVKeGotUK+KMPZNJUtGdlnK7lSNSxsPEiNZ0dwx6HhgDsmG0KnzOA0srBCyoYGki2gMZpWwH8nzZEgrIU2wKe0PhxbKVrGyHlKWzXeAHFjXMNAiMrSTZea4MOZJaBlhQIjbBQpmPyFGYAHuA=
Date: Mon, 5 Jun 2006 01:01:24 +0200
From: Frederik Deweerdt <deweerdt@free.fr>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [trivial patch, rc5-mm3] fix typo in acpi pm info message
Message-ID: <20060604230124.GA3168@slug>
References: <20060603232004.68c4e1e3.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060603232004.68c4e1e3.akpm@osdl.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There's a typo in an ACPI info message introduced by the following patch:
http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc5/2.6.17-rc5-mm3/broken-out/acpi-identify-which-device-is-not-power-manageable.patch

Here's the fix:

Signed-off-by: Frederik Deweerdt <frederik.deweerdt@gmail.com>

--- drivers/acpi/bus.c_	2006-06-05 00:48:44.000000000 +0200
+++ drivers/acpi/bus.c	2006-06-05 00:49:19.000000000 +0200
@@ -188,7 +188,7 @@ int acpi_bus_set_power(acpi_handle handl
 	/* Make sure this is a valid target state */
 
 	if (!device->flags.power_manageable) {
-		ACPI_INFO((AE_INFO, "Device `%s]is not power manageable",
+		ACPI_INFO((AE_INFO, "Device [%s] is not power manageable",
 				device->kobj.name));
 		return -ENODEV;
 	}
