Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261664AbTJHPxs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 11:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbTJHPxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 11:53:48 -0400
Received: from vwisb7.vkw.tu-dresden.de ([141.30.51.183]:61604 "EHLO
	vwisb7.vkw.tu-dresden.de") by vger.kernel.org with ESMTP
	id S261664AbTJHPxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 11:53:46 -0400
Date: Wed, 8 Oct 2003 17:53:45 +0200
From: Torsten Werner <email@twerner42.de>
To: linux-kernel@vger.kernel.org
Subject: NFS speed problem when appending data to existing files
Message-ID: <20031008155345.GA15071@vwisb7.vkw.tu-dresden.de>
Mail-Followup-To: Torsten Werner <email@twerner42.de>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.4.21 i686
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

the following command

for i in `seq 1 10240`; do dd if=/dev/zero bs=100 count=1 2> /dev/null | tee -a tmp0; done

is very slow on a nfs mounted homedir and I get lots of error messages

nfs: server xxxxxx not responding, still trying
nfs: server xxxxxx OK

on the client side (2.4.22, server is a 2.4.21 kernel based nfsd). Only
appending small amounts of data to an existing file shows the problem.
Writing a large file happens at FastEthernet speed flawlessly. Any help,
please?

Thanks,
Torsten

-- 
Torsten Werner                         Dresden University of Technology
email@twerner42.de                   +49 351 46336711 / +49 162 3123004
http://www.twerner42.de/                      telefax: +49 351 46336809

