Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262691AbTIQGzj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 02:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262692AbTIQGzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 02:55:39 -0400
Received: from users.linvision.com ([62.58.92.114]:52871 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id S262691AbTIQGze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 02:55:34 -0400
Date: Wed, 17 Sep 2003 08:55:23 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: linux-kernel@vger.kernel.org
Subject: HFS plus filenames. 
Message-ID: <20030917085523.B19276@bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

We used the new hfsplus driver lately. However it showed lots 
of files which had a "/" in the filename. Yes in the fileNAME. 

ls would find a file called "a/b" and then stat it, but no directory
"a" would then be found....

I tried modifying the unicode->ascii strcpy function, which I saw
being called in the "readdir" code. That somehow didn't work,
although I think it should have. (Not that it would have /worked/, but
it should at least have shown "a_b" instead of "a/b") But it didn't. 
I didn't have the time to figure it out, but one of these days
we should mangle those names in a predictable way to make filesystems
like this usable under Linux... Right?

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
**** "Linux is like a wigwam -  no windows, no gates, apache inside!" ****
