Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262079AbUEQSvn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262079AbUEQSvn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 14:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbUEQSvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 14:51:43 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:35545 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S262079AbUEQSvm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 14:51:42 -0400
Date: Mon, 17 May 2004 20:51:41 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: file attributes (ext2/3) in 2.4.26
Message-ID: <20040517185141.GA23102@MAIL.13thfloor.at>
Mail-Followup-To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Folks!

is it intentional that the file attributes
(those accessible with chattr -*) are modifyable
even if a file has the 'i' immutable flag set,
and the user is lacking CAP_IMMUTABLE (or all
CAPs if you prefer that ;)

# touch /tmp/x
# chattr +iaA /tmp/x

# lcap -z
# chattr -i /tmp/x 
chattr: Operation not permitted while setting flags on /tmp/x

# chattr -A /tmp/x 
# lsattr /tmp/x
----ia------- /tmp/x

I'd consider this a bug, but it might be some
strange posix/linux conformance issue too ...

let me know if this _is_ a bug, if so, I'm 
willing to provide patches to fix it ...

TIA,
Herbert

