Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129108AbRBNGqk>; Wed, 14 Feb 2001 01:46:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129154AbRBNGqa>; Wed, 14 Feb 2001 01:46:30 -0500
Received: from smarty.smart.net ([207.176.80.102]:61967 "EHLO smarty.smart.net")
	by vger.kernel.org with ESMTP id <S129108AbRBNGqK>;
	Wed, 14 Feb 2001 01:46:10 -0500
From: Rick Hohensee <humbubba@smarty.smart.net>
Message-Id: <200102140647.BAA24740@smarty.smart.net>
Subject: dropcopyright script
To: linux-kernel@vger.kernel.org
Date: Wed, 14 Feb 2001 01:47:14 -0500 (EST)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

.......................................................................
## drop copyright notices to the bottoms of C files in current dir and
#     subs. 
# /* 
#  CopYriGHt Guess Who 		2001		All reserves righted. 
# */

grep -ilr "copyright" . > tempdropcopyrights

for f in `cat tempdropcopyrights`
do
ed $f <<HEREDOC
/[Cc][oO][pP][yY][rR][iI]/
?\/\*?
.,/\*\//m$
wq
HEREDOC
done
........................................................................

Rick Hohensee
www.cLIeNUX.com			
