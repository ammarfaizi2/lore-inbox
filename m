Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261942AbRFDWGh>; Mon, 4 Jun 2001 18:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263881AbRFDWG1>; Mon, 4 Jun 2001 18:06:27 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:51465 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S261942AbRFDWGT>;
	Mon, 4 Jun 2001 18:06:19 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200106042205.f54M5dW139630@saturn.cs.uml.edu>
Subject: Re: symlink_prefix
To: viro@math.psu.edu (Alexander Viro)
Date: Mon, 4 Jun 2001 18:05:39 -0400 (EDT)
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0106031310070.27673-100000@weyl.math.psu.edu> from "Alexander Viro" at Jun 03, 2001 01:19:37 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:

> leaves ncp with its ioctls ugliness.

Authentication will be ugly. Joe mounts a filesystem, and does
not bother to authenticate. He gets world-accessible files.
Then Kevin authenticates as himself, and later as db_adm too.
Along comes Sue, who can authenticate the whole box as trusted.

The /fs/ext2 stuff is one of the nastiest hacks I've seen in
a long time, and it doesn't solve the authentication problem.

GUI users might like to see a dialog box pop up whenever they
hit restricted filesystem space. (example: an authentication tool
blocked on /dev/auth-notify or getting signals with info)

