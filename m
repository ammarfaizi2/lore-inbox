Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262092AbTJANIf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 09:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbTJANIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 09:08:35 -0400
Received: from bab72-140.optonline.net ([167.206.72.140]:26955 "EHLO
	shookay.newview.com") by vger.kernel.org with ESMTP id S262092AbTJANIc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 09:08:32 -0400
To: lisanels@cableone.net ("Lisa R. Nelson")
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: File Permissions are incorrect. Security flaw in Linux
References: <1065012013.4078.2.camel@lisaserver>
X-Face: %JOeya=Dg!}[/#Go&*&cQ+)){p1c8}u\Fg2Q3&)kothIq|JnWoVzJtCFo~4X<uJ\9cHK'.w 3:{EoxBR
From: Mathieu Chouquet-Stringer <mathieu@newview.com>
Date: 01 Oct 2003 09:08:30 -0400
In-Reply-To: <1065012013.4078.2.camel@lisaserver>
Message-ID: <xltr81x14xd.fsf@shookay.newview.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lisanels@cableone.net ("Lisa R. Nelson") writes:
> [1.] One line summary of the problem:    
> A low level user can delete a file owned by root and belonging to group
> root even if the files permissions are 744.  This is not in agreement
> with Unix, and is a major security issue.

That's perfectly normal, the directory where you put your files is writable
by anyone and that's what matters. To remove a file, you don't need
permission on the file but on the container, which is the directory in your
case.
Make the directory 1777 instead of 777 or try the same thing under /tmp.

-- 
Mathieu Chouquet-Stringer              E-Mail : mathieu@newview.com
       Never attribute to malice that which can be adequately
                    explained by stupidity.
                     -- Hanlon's Razor --
