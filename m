Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261268AbTH2NfR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 09:35:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261273AbTH2NfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 09:35:17 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:3513 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S261268AbTH2NfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 09:35:13 -0400
Date: Fri, 29 Aug 2003 10:30:52 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: olof@austin.ibm.com
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: /proc/ioports overrun patch
Message-ID: <Pine.LNX.4.55L.0308291025340.21063@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Olof,

Let me make sure I understood the patch right:

Your change to do_resource_list() will avoid copying out of bound by
truncating the resource output. Which means users might get truncated
information (only information that fits in the buffer) and not the full
information.

Is that correct?

If so, I would prefer to have a fix which outputs the full resource
information. For that we would need seq_file().

Please correct me if my reading of the code is wrong.

Thanks

