Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313057AbSDOHd7>; Mon, 15 Apr 2002 03:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313062AbSDOHd6>; Mon, 15 Apr 2002 03:33:58 -0400
Received: from smtp-out-6.wanadoo.fr ([193.252.19.25]:35465 "EHLO
	mel-rto6.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S313057AbSDOHd6>; Mon, 15 Apr 2002 03:33:58 -0400
Content-Type: text/plain; charset=US-ASCII
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: Leopold Gouverneur <lgouv@planetinternet.be>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.8 pre3 chown problem
Date: Mon, 15 Apr 2002 09:33:29 +0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020414193813.GA668@gouv>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16x0zT-0000ue-00@baldrick>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton posted this patch earlier:

--- linux-2.5.8-pre3/fs/open.c        Tue Apr  9 18:16:40 2002
+++ 25/fs/open.c      Thu Apr 11 00:15:09 2002
@@ -524,11 +524,11 @@ static int chown_common(struct dentry * 
              goto out;
      newattrs.ia_valid =  ATTR_CTIME;
      if (user != (uid_t) -1) {
-             newattrs.ia_valid =  ATTR_UID;
+             newattrs.ia_valid |= ATTR_UID;
              newattrs.ia_uid = user;
      }
      if (group != (gid_t) -1) {
-             newattrs.ia_valid =  ATTR_GID;
+             newattrs.ia_valid |= ATTR_GID;
