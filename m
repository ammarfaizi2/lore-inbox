Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317078AbSFXG1w>; Mon, 24 Jun 2002 02:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317416AbSFXG1v>; Mon, 24 Jun 2002 02:27:51 -0400
Received: from pizda.ninka.net ([216.101.162.242]:34778 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317078AbSFXG1u>;
	Mon, 24 Jun 2002 02:27:50 -0400
Date: Sun, 23 Jun 2002 23:21:45 -0700 (PDT)
Message-Id: <20020623.232145.130688831.davem@redhat.com>
To: kai-germaschewski@uiowa.edu
Cc: sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: Re: kbuild fixes and more
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0206232009270.24916-100000@chaos.physics.uiowa.edu>
References: <20020624000500.A11471@mars.ravnborg.org>
	<Pine.LNX.4.44.0206232009270.24916-100000@chaos.physics.uiowa.edu>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


BTW, Kai, a bug was added when you changed the path of the
'host-progs' value in drivers/video/Makefile, the build looks
for a dependency file that isn't there.

Amusingly, eliminating the host-progs line in this Makefile results in
a successful build.

This is an area that needs dealing with, a host build program that is
used by multiple directories.  I think conmakehash, this particular
case, belongs in scripts/.  That might be the generic solution to
build tools used by multiple places of the tree.
