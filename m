Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751926AbWJMVJP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751926AbWJMVJP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 17:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751931AbWJMVJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 17:09:14 -0400
Received: from cacti.profiwh.com ([85.93.165.66]:63469 "EHLO cacti.profiwh.com")
	by vger.kernel.org with ESMTP id S1751926AbWJMVI6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 17:08:58 -0400
Message-id: <2287885601299026682@wsc.cz>
Subject: [PATCH 6/7] Char: stallion, mark functions as init
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Date: Fri, 13 Oct 2006 23:09:10 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

stallion, mark functions as init

Use __init macro for functions, that may be freed after initialization.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit d98c2128256f2d3e12868353ae0b07e68f47428a
tree 895047d691ed284a2a174517032a76c4746cd5e8
parent 76e0df22163abb8b552f6e77652839b40a76752d
author Jiri Slaby <jirislaby@gmail.com> Fri, 13 Oct 2006 00:14:58 +0200
committer Jiri Slaby <jirislaby@gmail.com> Fri, 13 Oct 2006 00:14:58 +0200

 drivers/char/stallion.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/char/stallion.c b/drivers/char/stallion.c
index 02bd0ba..51f46c2 100644
--- a/drivers/char/stallion.c
+++ b/drivers/char/stallion.c
@@ -700,7 +700,7 @@ static struct class *stallion_class;
  *	Check for any arguments passed in on the module load command line.
  */
 
-static void stl_argbrds(void)
+static void __init stl_argbrds(void)
 {
 	struct stlconf	conf;
 	struct stlbrd	*brdp;
@@ -767,7 +767,7 @@ static unsigned long stl_atol(char *str)
  *	Parse the supplied argument string, into the board conf struct.
  */
 
-static int stl_parsebrd(struct stlconf *confp, char **argp)
+static int __init stl_parsebrd(struct stlconf *confp, char **argp)
 {
 	char	*sp;
 	int	i;
@@ -2016,7 +2016,7 @@ static int __init stl_initports(struct s
  *	Try to find and initialize an EasyIO board.
  */
 
-static int stl_initeio(struct stlbrd *brdp)
+static int __init stl_initeio(struct stlbrd *brdp)
 {
 	struct stlpanel	*panelp;
 	unsigned int	status;
@@ -2157,7 +2157,7 @@ static int stl_initeio(struct stlbrd *br
  *	dealing with all types of ECH board.
  */
 
-static int stl_initech(struct stlbrd *brdp)
+static int __init stl_initech(struct stlbrd *brdp)
 {
 	struct stlpanel	*panelp;
 	unsigned int	status, nxtid, ioaddr, conflict;
@@ -2416,7 +2416,7 @@ static int __init stl_brdinit(struct stl
  *	Find the next available board number that is free.
  */
 
-static int stl_getbrdnr(void)
+static int __init stl_getbrdnr(void)
 {
 	int	i;
 
@@ -2440,7 +2440,7 @@ #ifdef	CONFIG_PCI
  *	configuration space.
  */
 
-static int stl_initpcibrd(int brdtype, struct pci_dev *devp)
+static int __init stl_initpcibrd(int brdtype, struct pci_dev *devp)
 {
 	struct stlbrd	*brdp;
 
@@ -2502,7 +2502,7 @@ static int stl_initpcibrd(int brdtype, s
  */
 
 
-static int stl_findpcibrds(void)
+static int __init stl_findpcibrds(void)
 {
 	struct pci_dev	*dev = NULL;
 	int		i, rc;
@@ -2538,7 +2538,7 @@ #endif
  *	since the initial search and setup is too different.
  */
 
-static int stl_initbrds(void)
+static int __init stl_initbrds(void)
 {
 	struct stlbrd	*brdp;
 	struct stlconf	*confp;
