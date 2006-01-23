Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964833AbWAWGK6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964833AbWAWGK6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 01:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964835AbWAWGK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 01:10:58 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:52413 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964833AbWAWGK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 01:10:57 -0500
Subject: Re: [PATCH 4/4] pmap: reduced permissions
From: Arjan van de Ven <arjan@infradead.org>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: Al Viro <viro@ftp.linux.org.uk>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
In-Reply-To: <200601222219.k0MMJ3Qg209555@saturn.cs.uml.edu>
References: <200601222219.k0MMJ3Qg209555@saturn.cs.uml.edu>
Content-Type: text/plain
Date: Mon, 23 Jan 2006 07:10:54 +0100
Message-Id: <1137996654.2977.0.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-01-22 at 17:19 -0500, Albert D. Cahalan wrote:
> This patch changes all 3 remaining maps files to be readable
> only for the file owner. There have been privacy concerns.
> 
> Fedora Core 4 has been shipping with such permissions on
> the /proc/*/maps file already. General system monitoring
> tools seldom use these files.

changing /maps to 0400 breaks glibc; there are cases where this would
lead to /proc/self/maps to be not readable (setuid like apps) so this
needs a more elaborate fix.

