Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265642AbRFWFfJ>; Sat, 23 Jun 2001 01:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265643AbRFWFe7>; Sat, 23 Jun 2001 01:34:59 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:43025 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S265642AbRFWFep>;
	Sat, 23 Jun 2001 01:34:45 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
cc: stimits@idcomm.com, linux-kernel@vger.kernel.org
Subject: Re: Cleanup kbuild for aic7xxx 
In-Reply-To: Your message of "Fri, 22 Jun 2001 23:14:49 CST."
             <200106230514.f5N5EnU84722@aslan.scsiguy.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 23 Jun 2001 15:34:39 +1000
Message-ID: <13785.993274479@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jun 2001 23:14:49 -0600, 
"Justin T. Gibbs" <gibbs@scsiguy.com> wrote:
>Can you explain why this would be the case?  Are you saying that SGI
>is building the generated file and also keeping it in their revision
>control system?  If so, wouldn't their shipped config also include
>building the firmware?

SGI's source control system marks the supplied files as read only to
prevent accidental updates.  That causes problems when generated files
are updated in place, see my long memo about why this is bad.  I am
guessing that SGI had problems with the earlier version of your
Makefile (it always generated the files) so they excluded the generated
files from their repository.

Changing aic7xxx kbuild so it does not overwrite supplied files will
fix this class of problem for all source repositories, not just SGI.

