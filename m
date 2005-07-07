Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261294AbVGGL1V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbVGGL1V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 07:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbVGGL1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 07:27:21 -0400
Received: from coderock.org ([193.77.147.115]:21898 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261294AbVGGL0p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 07:26:45 -0400
Message-Id: <20050707112551.331553000@homer>
Date: Thu, 07 Jul 2005 13:25:51 +0200
From: domen@coderock.org
To: linux-kernel@vger.kernel.org
Cc: damm@opensource.se
Subject: [patch 0/5] autoparam v0.2: generating parameter descriptions on compile
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

The purpose of autoparam is to generate boot parameter descriptions
from sources. It does that by creating a new section called
__param_strings. (The interesting bits here are from Magnus Damm.)
It fills a gap about undocumented boot options from modules.

It consists of 5 patches:

autoparam_1-includes
  Descriptions get saved in __param_strings. Also added a new
  __setup_desc().

autoparam_2-makefile
  On every vmlinux change .kernel-parameters.o gets regenerated, and
  __param_strings removed from vmlinux. (It's still bigger than
  non-patched vmlinux, but all sections are of same length, alignment
  issues?)
  Also, a new target "make kernelparams" which generates
  Documentation/kernel-parameters-gen.txt. It should probably not be
  in $(srctree) though.
  There should be some more work done here, but I'm out of ideas ATM.

autoparam_3-extract_script
  Simple perl script to extract descriptions.

autoparam_4-af_unix_workaround
autoparam_5-ide_workaround
  Workarounds needed.


Comments, improvements?


	Domen

